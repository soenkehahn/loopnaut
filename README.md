`looper` is a tool that allows you to easily experiment with a simple form of
livecoding for audio generaton. It plays back snippets of audio in a gapless,
infinite loop. These snippets are meant to be generated by a program that can be
modified. `looper` then picks up the changes to the program, re-runs it, and
switches to the newly generated audio snippet in the next loop.

## how it works

Create an executable in a programming language of your choice that outputs
floating point numbers to `stdout`. These will be interpreted by `looper` as a
sequence of audio samples in mono, in 44100 Hertz between -1.0 to +1.0. Here's
an example python program `noise.py` that generates one second of noise:

```python
#!/usr/bin/env python

import random

for i in range(0, 44100):
    print((random.random() * 2.0) - 1.0)
```

The file has to have the executable flag set (with e.g. `chmod +x noise.py`).
Then run `looper`, passing in the executable file as an argument:

```bash
looper noise.py
```

This will run `noise.py`, collect the samples from its `stdout` and play them
back through your audio device in an infinite loop. Once you change and save the
program, `looper` will rerun it and switch to playing the new loop.

You can use this for a simple, experimental form of livecoding by modifying the
program over and over again and listening to the results.

## Installation

`looper` runs on linux and mac.

### Linux

There's pre-built binaries for linux [here](https://github.com/soenkehahn/looper/releases).

You will need to install some runtime dependencies to run `looper`. On ubuntu you can do:

```bash
sudo apt install libportaudio2 libsndfile1 libgmp10
```

### Building from source

These are instructions that work on ubuntu-19.10.

First, you need to install some looper dependencies and `curl`:

```bash
sudo apt-get update
sudo apt-get install --yes curl libsndfile1-dev portaudio19-dev
```

`looper` is written in Haskell and you need to install the Haskell build tool
[stack](https://haskellstack.org/) to build and install it. Here's how you can
get `stack`:

```bash
curl -sSL https://get.haskellstack.org/ | sh
```

Then you need to clone the `looper` repo:

```bash
git clone https://github.com/soenkehahn/looper
cd looper
```

And install looper with:

```bash
stack install
```

`stack` installs executables into `$HOME/.local/bin`. So you need to make sure that that's
added to your `$PATH`. If you're using `bash` you could do that with:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.bashrc
```

You need to restart bash for this to take effect.

Now you can check that looper is installed with e.g.:

```bash
looper --help
```

## Examples

- There are a few small examples in the `./examples` folder.
- I (Sönke) have toyed around with `looper` here: [loops](https://github.com/soenkehahn/loops).

If you have created anything with `looper` that is available publicly, we should add it to this list. :)
