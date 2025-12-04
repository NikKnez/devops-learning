# Package Management

## Commands Learned


### apt (Package Manager)
- `sudo apt update` - update package lists
- `sudo apt install pkg` - install package
- `sudo apt remove pkg` - remove package
- `apt search keyword` - search packages
- `apt show pkg` - package information


### dpkg (Package Files)
- `dpkg -l` - list installed
- `dpkg -L pkg` - files in package
- `dpkg -S file` - find owner
- `dpkg -i file.deb` - install .deb


### tar (Archives)
- `tar -czf archive.tar.gz dir/` - create
- `tar -xzf archive.tar.gz` - extract
- `tar -tzf archive.tar.gz` - list


## Key Concepts
- Repositories provide trusted software
- Dependencies auto-resolved by apt
- tar for archiving and distribution
- Compile from source when needed
