# homebrew-tap

A [Homebrew](https://brew.sh) tap for [ganvil](https://codeberg.org/ganvil/ganvil).

## Usage

### Install a formula

`brew install ganvil/tap/ganvil`

Or `brew tap ganvil/tap` and then `brew install ganvil`.

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "ganvil/tap"
brew "ganvil"
```

## Release

1. Update the formula:
   ```shell
   bash ./update.sh <version>
   ```
   Example:
   ```shell
   bash ./update.sh 0.3.0
   ```
2. Commit and push the changes.

## Development

### Setup

1.  Install the formula:
    ```shell
    brew install ganvil/tap/ganvil
    ```
1.  change to the tap directory:
    ```shell
    cd "$(brew --prefix)/Library/Taps/ganvil"
    ```
1.  Make changes to [`Formula/ganvil.rb`](./Formula/ganvil.rb).
1.  Re-install the formula to verify the changes:
    ```shell
    brew reinstall ganvil/tap/ganvil
    ```
