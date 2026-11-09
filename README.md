# prr

Review, approve and merge GitHub pull requests from the terminal, in one full-screen view.

Paste a PR link, read what the PR is about, look at the diff and the checks, then approve and merge without opening a browser.

```
prr https://github.com/owner/repo/pull/123
```

## Views

`←` / `→` switch between three views:

- **Description** (opens first): status line (author, branches, size, review state, merge state, checks), the PR description rendered as Markdown, and the changed files. Collapsed `<details>` sections stay folded, as on GitHub. `space` unfolds and folds them.
- **Diff**: syntax-highlighted with [delta](https://github.com/dandavison/delta). Loaded in the background when the PR opens, so it shows up instantly. `enter` opens it full screen, where `n` / `N` jump between files.
- **Checks**: checks on the left, failures first. The highlighted check's details are on the right: the steps of a GitHub Actions job, plus the failing log when it failed. `enter` opens the check in the browser.

## Keys

| Key | Does |
|---|---|
| `←` `→` | Switch view |
| `↑` `↓` | Scroll, or move through checks |
| `space` | Fold / unfold sections on the description, page down elsewhere |
| `enter` | Full-screen diff, or open the check in the browser |
| `a` | Approve, with an optional comment |
| `m` | Merge with your usual method for that repo. Offers to approve first, and offers auto-merge when checks are still running |
| `r` | Refresh |
| `o` | Open the PR in the browser |
| `q` | Back to the description, and quit from there |

Approve and merge always ask before doing anything.

## Ways to open a PR

- `prr <url>`. Any link into the PR works, for example to its files tab or a comment.
- `prr` with a PR link on the clipboard opens that PR.
- `prr` with no link on the clipboard lists the PRs waiting for your review, with a preview of each. Type to filter, `enter` opens one, `esc` quits.
- **macOS, from any app:** select a PR link, or copy it, then right-click and choose **Services → Review PR in iTerm**. It understands full links, links without `https://` and `owner/repo#123`. If Slack passes only the PR's title, copy the link first (right-click → Copy Link). A new iTerm window opens on the PR, on the desktop where iTerm lives (on your main display, the one with the menu bar). It closes when you quit `prr`, leaving you at your terminal.

## Install

Requires [gh](https://cli.github.com) (logged in), [fzf](https://github.com/junegunn/fzf) 0.59 or later, [delta](https://github.com/dandavison/delta), [glow](https://github.com/charmbracelet/glow), `jq` and `perl`. It's written for macOS (it uses `pbpaste` and `open`).

```bash
brew install gh fzf git-delta glow jq
git clone https://github.com/wwojtak/prr && cd prr && ./install.sh
```

`install.sh` links `prr` into `~/.local/bin`. On macOS it also installs the right-click Service, and an iTerm profile named "PR Review" that inherits from your Default profile. Pass `--no-service` to skip both. The first time you use the Service, macOS asks whether Automator may control iTerm.
