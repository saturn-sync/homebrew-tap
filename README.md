# homebrew-tap

A [Homebrew](https://brew.sh) tap for [Saturn](https://codeberg.org/saturn-sync/saturn).

## Usage

### Install a formula

`brew install saturn-sync/tap/saturn`

Or `brew tap saturn-sync/tap` and then `brew install saturn`.

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "saturn-sync/tap"
brew "saturn"
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
    brew install saturn-sync/tap/saturn
    ```
1.  change to the tap directory:
    ```shell
    cd "$(brew --prefix)/Library/Taps/saturn-sync"
    ```
1.  Make changes to [`Formula/saturn.rb`](./Formula/saturn.rb).
1.  Re-install the formula to verify the changes:
    ```shell
    brew reinstall saturn-sync/tap/saturn
    ```
