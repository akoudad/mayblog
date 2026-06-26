---
title: 'Building micrograd from scratch'
description: 'What actually clicked about backprop when I stopped reading and started writing it.'
pubDate: 2026-06-26
---

Backprop felt like magic until I wrote it. Then it felt obvious. That gap — magic to obvious — is the whole reason I rebuild things from scratch.

## The one idea

Every number in a neural net remembers how it was made. Add, multiply, `tanh` — each operation records its inputs. Once you have that chain, gradients flow backward through it. That's the engine. Everything else is bookkeeping.

## The core

A `Value` wraps a number and the operation that produced it:

```python
class Value:
    def __init__(self, data, _children=()):
        self.data = data
        self.grad = 0.0
        self._backward = lambda: None
        self._prev = set(_children)

    def __mul__(self, other):
        out = Value(self.data * other.data, (self, other))
        def _backward():
            self.grad += other.data * out.grad
            other.grad += self.data * out.grad
        out._backward = _backward
        return out
```

The detail that matters is `+=`. A value used in two places collects gradient from both paths. Use `=` instead and the network silently learns the wrong thing — no error, just bad results. That bug cost me an afternoon.

## The backward pass

Sort the graph so every node comes after its inputs (topological order), seed the output gradient with 1, then walk backward calling each local `_backward`:

```python
def backward(self):
    topo, visited = [], set()
    def build(v):
        if v not in visited:
            visited.add(v)
            for child in v._prev:
                build(child)
            topo.append(v)
    build(self)
    self.grad = 1.0
    for node in reversed(topo):
        node._backward()
```

About 150 lines and you have a working autograd engine. Layers, MLPs, training loops — all just chaining `Value`s and calling `backward()`.

## Why bother

I could `import torch` and never think about this. But the day a gradient explodes or a loss refuses to drop, the person who wrote `backward()` by hand debugs it in minutes. The person who didn't, guesses.

Next in this series: makemore, then a GPT, then the tokenizer underneath it.
