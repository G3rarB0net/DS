from abc import ABC, abstractmethod
import requests

# Clase base que será la interfaz para todos los LLM
class LLM(ABC):
    @abstractmethod
    def generate_summary(self, text, input_lang, output_lang, model):
        pass

# Implementación básica del LLM
class BasicLLM(LLM):
    def generate_summary(self, text, input_lang, output_lang, model):
        API_URL = f"https://api-inference.huggingface.co/models/{model}"
        headers = {"Authorization": "Bearer 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"}
        
        payload = {
            "inputs": text,
            "parameters": {
                "max_length": 130,
                "min_length": 30,
                "do_sample": False
            }
        }
        
        response = requests.post(API_URL, headers=headers, json=payload)
        
        if response.status_code != 200:
            raise Exception(f"Error {response.status_code}: {response.text}")
        try:
            return response.json()[0]['summary_text']
        except (KeyError, IndexError, requests.exceptions.JSONDecodeError):
            raise Exception("Invalid json response")
