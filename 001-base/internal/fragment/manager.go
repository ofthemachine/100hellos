package fragment

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/ofthemachine/100hellos/entrypoint/internal/config"
)

// Manager handles fragment injection workflow
type Manager struct {
	cfg *config.Config
}

// NewManager creates a new fragment manager
func NewManager(cfg *config.Config) *Manager {
	return &Manager{
		cfg: cfg,
	}
}

// Process handles the complete fragment injection process
func (m *Manager) Process() error {
	// Check if fragment file exists
	fragmentPath := filepath.Join(m.cfg.Paths.Fragments, m.cfg.Fragments.Marker)
	if _, err := os.Stat(fragmentPath); os.IsNotExist(err) {
		// Try in code directory (might have been copied during overlay)
		fragmentPath = filepath.Join(m.cfg.Paths.Code, m.cfg.Fragments.Marker)
		if _, err := os.Stat(fragmentPath); os.IsNotExist(err) {
			// No fragment file, skip injection
			return nil
		}
	}

	// Inject fragment
	injector := NewInjector(m.cfg.Fragments.Marker)
	if err := injector.Inject(m.cfg.Paths.Code, fragmentPath); err != nil {
		return fmt.Errorf("error injecting fragment: %w", err)
	}

	// Remove fragment file from code directory if it was copied there
	codeFragmentPath := filepath.Join(m.cfg.Paths.Code, m.cfg.Fragments.Marker)
	if _, err := os.Stat(codeFragmentPath); err == nil {
		os.Remove(codeFragmentPath)
	}

	return nil
}
