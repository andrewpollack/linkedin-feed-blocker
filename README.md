# LinkedIn Feed Blocker

A minimal Chrome extension that hides LinkedIn's home-feed posts while keeping the post composer and the rest of LinkedIn usable.

## Install

**Chrome Web Store:** Currently pending review. The listing will be available shortly [here](https://chromewebstore.google.com/detail/likdkcmiigfdfpkkecbcephijdfbegcf). In the meantime, follow the [manual installation instructions below](#manual-install).


## What it does

* Hides feed posts on `/feed` while keeping the post composer available
* Blocks infinite-scroll feed pagination
* Leaves profiles, jobs, search, messaging, notifications, and other LinkedIn features alone

## Why?

I like LinkedIn for finding jobs and chatting with recruiters. I do not like being greeted by the wild-west social feed.

After having "experienced" the Before image below, I decided to do something about it. Hence, this extension.

## Before / After

<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td><img src="assets/before.png" alt="Before: LinkedIn home page showing the full social feed, including a large post about a recruiter that 'came' on someone's profile. Yes, as-in _that_ 'came'."></td>
    <td><img src="assets/after.png" alt="After: LinkedIn home page with the post composer visible and feed posts hidden."></td>
  </tr>
</table>

## Manual install

1. Download or clone this repository somewhere permanent on your computer.

2. Open Chrome and go to:

   ```text
   chrome://extensions
   ```

3. Enable **Developer mode** in the top-right corner.

4. Click **Load unpacked**.

5. Select the `linkedin-feed-blocker` directory.

6. Reload LinkedIn.

The extension will remain enabled unless you disable or remove it from `chrome://extensions`.


## Developer Notes

### Updating

After changing `manifest.json`, `rules.json`, or `feed.css`:

1. Open `chrome://extensions`
2. Find **LinkedIn Feed Blocker**
3. Click **Reload**
4. Reload LinkedIn

### How it works

#### `feed.css`

Hides every section in LinkedIn's main-feed container, then restores only the section containing the post composer:

```css
[data-testid="mainFeed"] > * {
  display: none !important;
}

[data-testid="mainFeed"] > :has([aria-label="Start a post"]) {
  display: contents !important;
}
```

This selector intentionally fails closed: if LinkedIn changes the composer markup, the composer stays hidden rather than allowing feed posts through. It requires Chrome 105 or newer.

#### `rules.json`

Blocks requests for additional main-feed posts by targeting:

```text
sduiid=com.linkedin.sdui.pagers.feed.mainFeed
```

The rule intentionally targets LinkedIn's `mainFeed` pager instead of the generic pagination endpoint, which could interfere with other parts of LinkedIn.
