# Assuming you want to work with the top-most molecule loaded
set molID [molinfo top]

# Create an atom selection for all atoms in the molecule
set allAtoms [atomselect $molID "all"]

# Get the list of all residue names from the molecule
set allResNames [$allAtoms get resname]

# Destroy the atom selection to free up memory
$allAtoms delete

# Extract unique residue names
set uniqueResNames [lsort -unique $allResNames]

# Display counts for each unique residue name
puts "Counts for each Molecule (Residue) Type:"
foreach resname $uniqueResNames {
    # Count occurrences of this residue name in the allResNames list
    set sel [atomselect top "resname $resname"]
    set count [llength [lsort -unique [$sel get resid]]]
    # set count [llength [lsearch -all $allResNames $resname]]
    puts "$resname: $count"
}
