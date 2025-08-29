// -*- compile-command: "go run main.go"; -*-

// bump-version is used by the maintainer of this repo to bump the example
// versions to match the latest version of the spin-moonbit-sdk.
package main

import (
	"io/fs"
	"log"
	"os"
	"path/filepath"
	"regexp"
	"runtime"
	"strings"
)

const (
	sdkVerRelPath = "../moonbit-10-spin-sdk/moon.mod.json"
)

var (
	versionRE = regexp.MustCompile(`(?ms)^\s*"version": "(.*?)",?$`)
	newVerRE  = regexp.MustCompile(`(?ms)^\s*"gmlewis/spin-moonbit-sdk"\s*: "(.*?)",?$`)
)

func main() {
	log.SetFlags(0)

	_, prgFile, _, _ := runtime.Caller(0)
	repoDir := filepath.Join(filepath.Dir(prgFile), "../../")
	versionFile := filepath.Join(repoDir, sdkVerRelPath)
	buf, err := os.ReadFile(versionFile)
	must(err)
	m := versionRE.FindStringSubmatch(string(buf))
	if len(m) != 2 {
		log.Fatalf("Unable to find version in file:\n%s", buf)
	}
	newVersion := m[1]
	processFiles(repoDir, newVersion)

	log.Printf("Done.")
}

var skipDirs = map[string]bool{
	".git":       true,
	".mooncakes": true,
	".spin":      true,
	"target":     true,
}

func processFiles(baseDir, newVersion string) {
	fileSystem := os.DirFS(baseDir)
	fs.WalkDir(fileSystem, ".", func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			log.Fatal(err)
		}
		baseName := filepath.Base(path)
		if skipDirs[baseName] {
			return fs.SkipDir
		}
		if baseName != "moon.mod.json" {
			return nil
		}
		processFile(filepath.Join(baseDir, path), newVersion)
		return nil
	})
}

func processFile(path, newVersion string) {
	buf, err := os.ReadFile(path)
	must(err)
	m := newVerRE.FindStringSubmatch(string(buf))
	if len(m) != 2 {
		log.Fatalf("could not find version in %v:\n%s", path, buf)
	}
	oldVersion := m[1]

	out := strings.Replace(string(buf), oldVersion, newVersion, 1)
	must(os.WriteFile(path, []byte(out), 0644))
}

func must(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
