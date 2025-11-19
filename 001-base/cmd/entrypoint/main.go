package main

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/ofthemachine/100hellos/entrypoint/internal/config"
	"github.com/ofthemachine/100hellos/entrypoint/internal/executor"
	"github.com/ofthemachine/100hellos/entrypoint/internal/fragment"
	"github.com/ofthemachine/100hellos/entrypoint/internal/overlay"
)

func main() {
	// Load configuration
	cfg, err := config.Load(config.DefaultConfigPath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error loading config: %v\n", err)
		os.Exit(1)
	}

	// Handle subcommands
	if len(os.Args) > 1 {
		switch os.Args[1] {
		case "how-to":
			showDocumentation(cfg, cfg.Paths.HowTo, "No how-to documentation found in this container.")
			return
		case "agent-help", "help":
			showDocumentation(cfg, cfg.Paths.AgentHelp, "No agent-help documentation found in this container.")
			return
		}
	}

	// Overlay files from fragments to code
	if err := overlay.Overlay(cfg.Paths.Fragments, cfg.Paths.Code, cfg.Fragments.Marker); err != nil {
		fmt.Fprintf(os.Stderr, "Error overlaying files: %v\n", err)
		os.Exit(1)
	}

	// Process fragment injection
	fragmentMgr := fragment.NewManager(cfg)
	if err := fragmentMgr.Process(); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}

	// Execute code or pass through args
	exec := executor.NewExecutor(cfg)

	var args []string
	if len(os.Args) > 1 {
		args = os.Args[1:]
	}

	if err := exec.ExecuteWithArgs(args); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
}

func showDocumentation(cfg *config.Config, configuredPath, notFoundMsg string) {
	// Try configured path first
	if data, err := os.ReadFile(configuredPath); err == nil {
		fmt.Print(string(data))
		return
	}

	// Try in code directory using the filename from configured path
	filename := filepath.Base(configuredPath)
	codePath := filepath.Join(cfg.Paths.Code, filename)
	if data, err := os.ReadFile(codePath); err == nil {
		fmt.Print(string(data))
		return
	}

	fmt.Println(notFoundMsg)
}
