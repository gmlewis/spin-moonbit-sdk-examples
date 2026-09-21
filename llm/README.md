# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this post: https://spinframework.dev/v3/ai-sentiment-analysis-api-tutorial#application-structure
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

This demo is built upon this blog post:
https://developer.fermyon.com/spin/v2/ai-sentiment-analysis-api-tutorial

First, set up the llm model (WARNING: this is a 6.5GB download!):

```shell
# llama2-chat - first accept the license, then get the following files:
mkdir -p .spin/ai-models/llama/llama2-chat
pushd .spin/ai-models/llama/llama2-chat
wget https://huggingface.co/meta-llama/Llama-2-13b-chat-hf/resolve/main/config.json?download=true
wget https://huggingface.co/meta-llama/Llama-2-13b-chat-hf/resolve/main/model.safetensors.index.json?download=true
wget https://huggingface.co/meta-llama/Llama-2-13b-chat-hf/resolve/main/tokenizer.json?download=true
wget https://huggingface.co/meta-llama/Llama-2-13b-chat-hf/resolve/main/model-00001-of-00003.safetensors?download=true
wget https://huggingface.co/meta-llama/Llama-2-13b-chat-hf/resolve/main/model-00002-of-00003.safetensors?download=true
wget https://huggingface.co/meta-llama/Llama-2-13b-chat-hf/resolve/main/model-00003-of-00003.safetensors?download=true
popd
```

In one terminal window, start up the app:

```shell
$ spin build --up
```

Then in another terminal window, get the llm results:

```shell
$ curl -i localhost:3000/llm
HTTP/1.1 200 OK
content-type: application/json
transfer-encoding: chunked
date: Sat, 02 Aug 2025 21:21:18 GMT

{
  text: "tell me a joke or a funny story about something that happened to you\n\nSure, here's a joke:\n\nWhy couldn't the bicycle stand up by itself?\n\nBecause it was two-tired! (get it? two-tired, like a bike with two tires, but also tired because it can't stand up)\n\nAnd here's a funny story:\n\nOne time, I was at the grocery store...",
  usage: { prompt_token_count: 106, generated_token_count: 100 },
}

$ curl -i -X POST -d 'tell me a joke' localhost:3000/llm
HTTP/1.1 200 OK
content-type: application/json
transfer-encoding: chunked
date: Mon, 14 Sep 2026 01:49:33 GMT

{
  text: "tell me a joke about a cactus\n\nSure! Here's one:\n\nWhy did the cactus go to the party?\n\nBecause it was a prickly good time!",
  usage: { prompt_token_count: 48, generated_token_count: 42 },
}
```

The body is the `Debug` representation of `InferencingResult`, so it is
pretty-printed rather than valid JSON. Model output varies between runs.

