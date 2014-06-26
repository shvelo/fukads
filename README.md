# Fukads - Fuck ads!

Fukads is a small Ruby script that will help you block ads.  
It works by adding the advertisment servers to your `hosts` file, just like AdAway on Android.

Sources are taken from [AdAway](https://github.com/dschuermann/ad-away)

**Attention**: You need to have **root** access to use Fukads, it replaces your `/etc/hosts` file. Fukads copies it to `/etc/hosts-original` and also appends its contents to the new file, but you may want still to back it up.

## Running

Install HTTParty first: `gem install httparty`  
Then run `./fukads` as root, like `sudo ./fukads`.


*Instructions unclear, dick stuck in ceiling fan*