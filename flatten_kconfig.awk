# Usage: awk -f flatten.awk -v ARCH="x86" Kconfig
function include_file(filename,    line, path) {
    # 1. Clean up windows line endings and quotes
    gsub(/"/, "", filename);
    
    # 2. Handle environment variables (e.g., $SRCARCH)
    gsub(/\$SRCARCH/, ARCH, filename);
    gsub(/\$\(SRCARCH\)/, ARCH, filename);

    # 3. Read the file line-by-line
    while ((getline line < filename) > 0) {
        # Check for standard source
        if (line ~ /^[ \t]*source[ \t]+/) {
            match(line, /source[ \t]+"(.*)"/, arr);
            path = arr[1];
            
            # Print a comment anchor for debugging your flatter file
            print "# --- START OF: " path " ---";
            include_file(path); 
            print "# --- END OF: " path " ---";
        } 
        # Check for relative source (rsource)
        else if (line ~ /^[ \t]*rsource[ \t]+/) {
            # You will need to extract the current base directory 
            # from 'filename' and prepend it to the match here.
            print "# FIXME: Handle rsource manually or resolve path stack";
        }
        else {
            print line;
        }
    }
    close(filename);
}

BEGIN {
    # Start the recursion with the root file passed in the argument
    include_file(ARGV[1]);
    exit;
}
