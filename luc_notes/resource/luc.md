```bash
mkdir myapp
cd myapp
echo "source 'https://rubygems.org'" > Gemfile
echo "gem 'rails', '4.2.9'" >> Gemfile
bundle install

bundle exec rails new . --force --skip-bundle
bundle update
```
