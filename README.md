# rails-server-cookbook
A chef cookbook used to create a generic rails server

## Usage

metadata.rb
```
depends 'rails-server', git: 'git@github.com:spartaglobal/rails-server-cookbook.git'
```

default.rb
```
include_recipe 'rails-server::default'
```

