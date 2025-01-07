let subs = [
    math-101
    math-152
    phys-158
    phys-170
    wrds-150b
]

def orig-dir [...extra: string] {
    $"../../src/study/($extra | path join)"
}

for sub in $subs {
    if not ((orig-dir | path type) == dir) {
        print $"No such subject: ($sub)"
        exit 1
    }
    if not ((orig-dir $sub main.pdf | path type) == file) {
        print $"No main.pdf in ($sub)"
        exit 2
    }

    if not (orig-dir $sub | path exists) {
        mkdir $"($sub)"
    }
    cp (orig-dir $sub main.pdf) $"($sub)/($sub).pdf"
}

if (git status --porcelain) == "" {
    print "No changes"
    exit 0
}

git add .
git commit -m "update"
git push
