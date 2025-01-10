let subs = [
    apsc-101
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
    if not ((orig-dir $sub main.typ | path type) == file) {
        print $"No main.typ in ($sub)"
        exit 2
    }

    if not ($sub | path exists) {
        mkdir $"($sub)"
    }

    cp (orig-dir $sub main.typ) $"($sub)/($sub).typ"
    if (orig-dir $sub assets | path exists) {
        if ($"($sub)/assets" | path exists) {
            rm -r $"($sub)/assets"
        }
        cp -r (orig-dir $sub assets) $"($sub)/($sub)/assets"
    }
    if ((orig-dir $sub main.pdf | path type) == file) {
        cp (orig-dir $sub main.pdf) $"($sub)/($sub).pdf"
    }

}

git pull

if (git status --porcelain) == "" {
    print "No changes"
    exit 0
}

git add .
git commit -m "update"
git push
