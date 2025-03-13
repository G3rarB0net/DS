
from abc import ABC, abstractmethod
import requests

from llm import LLM

class TranslationDecorator(LLM):
    def __init__(self, llm, translation_model):
        self._llm = llm
        self.translation_model = translation_model

    def generate_summary(self, text, input_lang, output_lang, model):
        translated_text = self._translate(text, input_lang, output_lang)
        return self._llm.generate_summary(translated_text, output_lang, output_lang, model)

    def _translate(self, text, src_lang, tgt_lang):
        API_URL = f"https://api-inference.huggingface.co/models/{self.translation_model}"
        headers = {"Authorization": "Bearer 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"}
        
        payload = {
            "inputs": text,
            "parameters": {
                "src_lang": self._convert_lang(src_lang),
                "tgt_lang": self._convert_lang(tgt_lang)
            }
        }
        
        response = requests.post(API_URL, headers=headers, json=payload)

        if response.status_code != 200:
            raise Exception(f"Error {response.status_code}: {response.text}")
        try:
            return response.json()[0]['translation_text']
        except (KeyError, IndexError, requests.exceptions.JSONDecodeError):
            raise Exception("Invalid JSON response")

    def _convert_lang(self, lang):
        return f"{lang}_Latn" if lang in ["es", "en"] else f"{lang}_Cyrl"
    
        

class ExpansionDecorator(LLM):
    def __init__(self, llm, expansion_model):
        self._llm = llm
        self.expansion_model = expansion_model

    def generate_summary(self, text, input_lang, output_lang, model):
        summary = self._llm.generate_summary(text, input_lang, output_lang, model)
        return self._expand(summary, output_lang)

    def _expand(self, text, target_lang):
        API_URL = f"https://api-inference.huggingface.co/models/{self.expansion_model}"
        headers = {"Authorization": "Bearer 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"}
        
        prompt = f"Expand this summary into a detailed paragraph in its own language: {text}"  # Prompt en inglés
        payload = {
            "inputs": prompt,
            "parameters": {
                "max_length": 200,
                "temperature": 0.7
            }
        }
        
        response = requests.post(API_URL, headers=headers, json=payload)
        
        if response.status_code != 200:
            raise Exception(f"Error {response.status_code}: {response.text}")
        
        try:
            return response.json()[0]['generated_text']
        except (KeyError, IndexError, requests.exceptions.JSONDecodeError):
            raise Exception("Invalid JSON response")