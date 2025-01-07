let subs = [
    math-152
    phys-158
    phys-170
    wrds-150b
]

for sub in $subs {
    if not (($"../study/($sub)" | path type) == dir) {
        print $"No such subject: ($sub)"
        exit 1
    }
    if not (($"../study/($sub)/main.pdf" | path type) == file) {
        print $"No main.pdf in ($sub)"
        exit 2
    }

    if not ($"($sub)" | path exists) {
        mkdir $"($sub)"
    }
    cp $"../study/($sub)/main.pdf" $"($sub)/($sub).pdf"
}

if (git status --porcelain) == "" {
    print "No changes"
    exit 0
}

git add .
git commit -m "update"
git push
