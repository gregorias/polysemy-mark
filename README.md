# polysemy-mark

An exploration project inspired by ["Polysemy is
fun"](https://haskell-explained.gitlab.io/blog/posts/2019/07/28/polysemy-is-cool-part-1/index.html)
that explores using [Polysemy][polysemy] to express single file IO. For more
information see [my Obsidian
notes](obsidian://open?vault=Zettelkasten&file=Zettelkasten%2FI%20just%20want%20to%20access%20one%20file).

## Development

This section is intended for developers. It describes development related matters.

### Dev environment setup


1. Install hlint and fourmolu, which are used in pre-commits (I do it from my home directory):

   ```shell
   stack install hlint fourmolu
   ```

2. To install some development tools (commitlint), set up npm:

   ```shell
   npm install
   ```

3. To setup Git hooks, install lefthook:

   ```shell
   lefthook install
   ```

[polysemy]: https://github.com/polysemy-research/polysemy#readme
