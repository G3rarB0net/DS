# main.py (versión completa)
import json
from llm import BasicLLM
from decorators import TranslationDecorator, ExpansionDecorator

# Cargar configuración desde el archivo JSON
with open('config.json', 'r') as f:
    config = json.load(f)

# Instanciar el LLM base
basic_llm = BasicLLM()

# Generar resumen básico
resumen_basico = basic_llm.generate_summary(
    config['texto'],
    config['input_lang'],
    config['output_lang'],
    config['model_llm']
)

# Traducción del resumen básico
translated_llm = TranslationDecorator(basic_llm, config['model_translation'])
resumen_traducido = translated_llm.generate_summary(
    config['texto'],
    config['input_lang'],
    config['output_lang'],
    config['model_llm']
)

# Ampliación del resumen básico
expanded_llm = ExpansionDecorator(basic_llm, config['model_expansion'])
resumen_ampliado = expanded_llm.generate_summary(
    config['texto'],
    config['input_lang'],
    config['output_lang'],
    config['model_llm']
)

# Combinación: Traducción + Ampliación
combined_llm = ExpansionDecorator(translated_llm, config['model_expansion'])
resumen_combinado = combined_llm.generate_summary(
    config['texto'],
    config['input_lang'],
    config['output_lang'],
    config['model_llm']
)

# Imprimir los resultados
print("\n Resumen básico:", resumen_basico)
print("\n Resumen traducido:", resumen_traducido)
print("\n Resumen ampliado:", resumen_ampliado)
print("\n Resumen combinado (traducido + ampliado):", resumen_combinado)