#!/usr/bin/tclsh

proc load_menutree {} {
    # load object -> tags mapping from file in Pd's path
    set testfile "../right-click-menu/menutree.tcl"
    set f [open $testfile]
    # filter out commented out lines from the data file
    set menutree [regsub -all {\n\s*#[^\n]*} [read $f] "\n"]
    close $f
    unset f        
    return $menutree
}

proc create_folders {} {
    set menutree [load_menutree]
    foreach categorylist $menutree {
        set category [lindex $categorylist 0]
        file mkdir "$category"
        foreach subcategorylist [lrange $categorylist 1 end] {
            set subcategory [lindex $subcategorylist 0]
            file mkdir "$category/$subcategory"
        }
    }
}

create_folders

