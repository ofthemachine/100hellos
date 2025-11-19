package config

import (
	"encoding/json"
	"fmt"
	"os"
)

const (
	DefaultConfigPath = "/entrypoint.json"
)

// Config represents the entrypoint configuration
type Config struct {
	Version   string    `json:"version,omitempty"`
	Paths     Paths     `json:"paths,omitempty"`
	Fragments Fragments `json:"fragments,omitempty"`
	Execution Execution `json:"execution,omitempty"`
}

// Paths defines directory paths
type Paths struct {
	Code      string `json:"code,omitempty"`
	Fragments string `json:"fragments,omitempty"`
	HowTo     string `json:"howTo,omitempty"`
	AgentHelp string `json:"agentHelp,omitempty"`
}

// Fragments defines fragment injection settings
type Fragments struct {
	Marker string `json:"marker,omitempty"`
}

// Execution defines code execution settings
type Execution struct {
	Patterns       []string `json:"patterns,omitempty"`
	MakeExecutable *bool    `json:"makeExecutable,omitempty"`
	UseSudo        *bool    `json:"useSudo,omitempty"`
}

// ShouldMakeExecutable returns whether files should be made executable, defaulting to true
func (e *Execution) ShouldMakeExecutable() bool {
	if e.MakeExecutable == nil {
		return true
	}
	return *e.MakeExecutable
}

// ShouldUseSudo returns whether to use sudo for chmod, defaulting to false
func (e *Execution) ShouldUseSudo() bool {
	if e.UseSudo == nil {
		return false
	}
	return *e.UseSudo
}

// Defaults returns a Config with all default values
func Defaults() *Config {
	return &Config{
		Paths: Paths{
			Code:      "/code",
			Fragments: "/code-fragments",
			HowTo:     "/how-to.md",
			AgentHelp: "/agent-help.md",
		},
		Fragments: Fragments{
			Marker: "MAIN",
		},
		Execution: Execution{
			Patterns:       []string{"hello-world.sh", "hello-world.*"},
			MakeExecutable: nil, // nil means use default (true)
			UseSudo:        nil, // nil means use default (false)
		},
	}
}

// Load loads configuration from a file, merging with defaults
func Load(path string) (*Config, error) {
	cfg := Defaults()

	// If config file doesn't exist, return defaults
	if _, err := os.Stat(path); os.IsNotExist(err) {
		return cfg, nil
	}

	data, err := os.ReadFile(path)
	if err != nil {
		return nil, fmt.Errorf("failed to read config file: %w", err)
	}

	// Parse JSON into a temporary struct to merge
	var fileCfg Config
	if err := json.Unmarshal(data, &fileCfg); err != nil {
		return nil, fmt.Errorf("failed to parse config file: %w", err)
	}

	// Merge file config with defaults (only override if non-empty)
	cfg.merge(&fileCfg)

	return cfg, nil
}

// merge merges non-empty values from other into cfg
func (cfg *Config) merge(other *Config) {
	if other.Paths.Code != "" {
		cfg.Paths.Code = other.Paths.Code
	}
	if other.Paths.Fragments != "" {
		cfg.Paths.Fragments = other.Paths.Fragments
	}
	if other.Paths.HowTo != "" {
		cfg.Paths.HowTo = other.Paths.HowTo
	}
	if other.Paths.AgentHelp != "" {
		cfg.Paths.AgentHelp = other.Paths.AgentHelp
	}
	if other.Fragments.Marker != "" {
		cfg.Fragments.Marker = other.Fragments.Marker
	}
	if len(other.Execution.Patterns) > 0 {
		cfg.Execution.Patterns = other.Execution.Patterns
	}
	// Only merge bools if they were explicitly set (non-nil)
	if other.Execution.MakeExecutable != nil {
		cfg.Execution.MakeExecutable = other.Execution.MakeExecutable
	}
	if other.Execution.UseSudo != nil {
		cfg.Execution.UseSudo = other.Execution.UseSudo
	}
}
