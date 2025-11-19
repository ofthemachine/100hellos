package executor

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/ofthemachine/100hellos/entrypoint/internal/config"
)

// Executor handles finding and executing code files
type Executor struct {
	cfg *config.Config
}

// NewExecutor creates a new executor
func NewExecutor(cfg *config.Config) *Executor {
	return &Executor{
		cfg: cfg,
	}
}

// Execute finds and executes the code file
func (e *Executor) Execute() error {
	return e.executeWithArgs(nil)
}

// ExecuteWithArgs executes the code file and passes remaining args
func (e *Executor) ExecuteWithArgs(args []string) error {
	return e.executeWithArgs(args)
}

// executeWithArgs is the shared implementation
func (e *Executor) executeWithArgs(args []string) error {
	// Change to code directory
	if err := os.Chdir(e.cfg.Paths.Code); err != nil {
		return fmt.Errorf("failed to change to code directory: %w", err)
	}

	// Try each pattern in order
	for _, pattern := range e.cfg.Execution.Patterns {
		matches, err := filepath.Glob(pattern)
		if err != nil {
			return fmt.Errorf("failed to glob %s: %w", pattern, err)
		}

		if len(matches) > 0 {
			file := matches[0]
			if e.cfg.Execution.ShouldMakeExecutable() {
				if err := e.makeExecutable(file); err != nil {
					return err
				}
			}

			// Execute the file
			cmd := exec.Command("./"+file, args...)
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr
			return cmd.Run()
		}
	}

	// No code file found, if args provided, execute them directly (pass-through)
	if len(args) > 0 {
		cmd := exec.Command(args[0], args[1:]...)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		return cmd.Run()
	}

	return fmt.Errorf("no matching file found in %s using patterns: %v", e.cfg.Paths.Code, e.cfg.Execution.Patterns)
}

// makeExecutable makes a file executable, using sudo if configured
func (e *Executor) makeExecutable(file string) error {
	if e.cfg.Execution.ShouldUseSudo() {
		cmd := exec.Command("sudo", "chmod", "+x", file)
		if err := cmd.Run(); err != nil {
			return fmt.Errorf("failed to make %s executable with sudo: %w", file, err)
		}
	} else {
		if err := os.Chmod(file, 0755); err != nil {
			return fmt.Errorf("failed to make %s executable: %w", file, err)
		}
	}
	return nil
}
