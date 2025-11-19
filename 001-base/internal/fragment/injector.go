package fragment

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

// Injector handles fragment injection into code files
type Injector struct {
	marker string
}

// NewInjector creates a new fragment injector
func NewInjector(marker string) *Injector {
	return &Injector{
		marker: marker,
	}
}

// Inject injects the fragment content into files in the code directory
func (i *Injector) Inject(codeDir, fragmentPath string) error {
	// Read fragment content
	fragmentContent, err := os.ReadFile(fragmentPath)
	if err != nil {
		return fmt.Errorf("failed to read fragment file: %w", err)
	}

	fragmentLines := strings.Split(string(fragmentContent), "\n")

	// Walk through all files in code directory
	return filepath.Walk(codeDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		// Skip directories
		if info.IsDir() {
			return nil
		}

		// Read file content
		content, err := os.ReadFile(path)
		if err != nil {
			return err
		}

		lines := strings.Split(string(content), "\n")
		var newLines []string
		modified := false

		// Pattern to match marker on its own line (with optional whitespace)
		markerPattern := regexp.MustCompile(`^[ \t]*` + regexp.QuoteMeta(i.marker) + `[ \t]*$`)

		for _, line := range lines {
			if markerPattern.MatchString(line) {
				// Extract indentation from marker line
				indent := extractIndentation(line)

				// Replace marker with indented fragment lines
				for _, fragLine := range fragmentLines {
					if fragLine == "" || strings.TrimSpace(fragLine) == "" {
						// Preserve empty lines
						newLines = append(newLines, "")
					} else {
						// Prepend indentation to each fragment line
						newLines = append(newLines, indent+fragLine)
					}
				}
				modified = true
			} else {
				newLines = append(newLines, line)
			}
		}

		// Write back if modified
		if modified {
			newContent := strings.Join(newLines, "\n")
			if err := os.WriteFile(path, []byte(newContent), info.Mode()); err != nil {
				return fmt.Errorf("failed to write file %s: %w", path, err)
			}
		}

		return nil
	})
}

// extractIndentation extracts leading whitespace from a line
func extractIndentation(line string) string {
	for i, r := range line {
		if r != ' ' && r != '\t' {
			return line[:i]
		}
	}
	return line
}
