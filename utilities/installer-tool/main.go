package main

import "github.com/rivo/tview"

// main is the entry point of the program.
func main() {
	box := tview.NewBox().SetBorder(true).SetTitle("Installer Tool")
	if err := tview.NewApplication().SetRoot(box, true).Run(); err != nil {
		panic(err)
	}
}
