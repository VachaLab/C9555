import MDAnalysis as mda

# Load your DCD file
u = mda.Universe('r5.pdb', 'rg2.dcd')  # Replace 'topology_file.top' with your topology file

# Total number of frames in the DCD file
total_frames = len(u.trajectory)

# Calculate the interval to get approximately 100 equally spaced frames
interval = total_frames // 100

# Generate a list of frame indices
frames_to_keep = list(range(0, total_frames, interval))

# Write selected frames to a new DCD file
with mda.Writer('rg_condensed.dcd', n_atoms=u.atoms.n_atoms) as W:
    for frame_index in frames_to_keep:
        u.trajectory[frame_index]  # set the current frame
        W.write(u)

# End of script
