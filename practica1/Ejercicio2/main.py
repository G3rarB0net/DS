import json
from llm import BasicLLM
from decorators import TranslationDecorator, ExpansionDecorator

if __name__ == "__main__":
    with open('config.json', 'r') as f:
        config = json.load(f)

    basic_llm = BasicLLM()

    translated_llm = TranslationDecorator(basic_llm, config['model_translation'])
    expanded_llm = ExpansionDecorator(basic_llm, config['model_expansion'])
    combined_llm = ExpansionDecorator(translated_llm, config['model_expansion'])

    # Generar resumen básico
    resumen_basico = basic_llm.generate_summary(
        config['texto'],
        config['input_lang'],
        config['output_lang'],
        config['model_llm']
    )

    # Generar resumen traducido
    resumen_traducido = translated_llm.generate_summary(
        config['texto'],
        config['input_lang'],
        config['output_lang'],
        config['model_llm']
    )

    # Generar resumen ampliado
    resumen_ampliado = expanded_llm.generate_summary(
        config['texto'],
        config['input_lang'],
        config['output_lang'],
        config['model_llm']
    )

    # Generar resumen combinado (traducido + ampliado)
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
