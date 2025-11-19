package overlay

import (
	"fmt"
	"os"
	"path/filepath"
)

// Overlay copies files from fragments directory to code directory,
// excluding fragment marker files (like MAIN)
func Overlay(fragmentsDir, codeDir, marker string) error {
	// Check if fragments directory exists and has content
	entries, err := os.ReadDir(fragmentsDir)
	if err != nil {
		if os.IsNotExist(err) {
			// No fragments directory, nothing to overlay
			return nil
		}
		return fmt.Errorf("failed to read fragments directory: %w", err)
	}

	if len(entries) == 0 {
		// Empty directory, nothing to overlay
		return nil
	}

	// Ensure code directory exists
	if err := os.MkdirAll(codeDir, 0755); err != nil {
		return fmt.Errorf("failed to create code directory: %w", err)
	}

	// Copy files, excluding the marker file
	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}

		// Skip the fragment marker file (e.g., MAIN)
		if entry.Name() == marker {
			continue
		}

		srcPath := filepath.Join(fragmentsDir, entry.Name())
		dstPath := filepath.Join(codeDir, entry.Name())

		// Read source file
		data, err := os.ReadFile(srcPath)
		if err != nil {
			return fmt.Errorf("failed to read source file %s: %w", srcPath, err)
		}

		// Write destination file
		if err := os.WriteFile(dstPath, data, entry.Type().Perm()); err != nil {
			return fmt.Errorf("failed to write destination file %s: %w", dstPath, err)
		}
	}

	return nil
}

