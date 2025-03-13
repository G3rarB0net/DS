import requests
import yaml
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time
from abc import ABC, abstractmethod

# Interfaz del patrón strategy
class ScrapingStrategy(ABC):
    @abstractmethod
    def scrape(self, url):
        pass

# Estrategia con BeautifulSoup
class BeautifulSoupStrategy(ScrapingStrategy):
    def scrape(self, url):
        response = requests.get(url)
        soup = BeautifulSoup(response.text, "html.parser")
        quotes = []

        for quote in soup.select(".quote"):
            text = quote.find("span", class_="text").get_text()
            author = quote.find("small", class_="author").get_text()
            tags = [tag.get_text() for tag in quote.find_all("a", class_="tag")]
            
            quotes.append({"text": text, "author": author, "tags": tags})

        return quotes
        
# Estrategia con Selenium
class SeleniumStrategy(ScrapingStrategy):
    def __init__(self):
        options = Options() # Añade las opciones
        options.add_argument("--headless") # Opción: Hace que no se abra el navegador, por tanto el scraping será más rápido
        self.driver = webdriver.Chrome(service=Service("/usr/local/bin/chromedriver"), options=options)

    def scrape(self, url):
        self.driver.get(url) # Abre la url en el navegador
        time.sleep(2) # Espera para que cargue cmpletamente la página

        quotes = []
        elements = self.driver.find_elements(By.CLASS_NAME, "quote") # Busca todos los elementis de la página con la clase "quote"

        for quote in elements:
            text = quote.find_element(By.CLASS_NAME, "text").text
            author = quote.find_element(By.CLASS_NAME, "author").text
            tags = [tag.text for tag in quote.find_elements(By.CLASS_NAME, "tag")]
            quotes.append({"text": text, "author": author, "tags": tags})

        return quotes
    
    def __end__(self):
        self.driver.quit()


class Scraper:
    def __init__(self, strategy: ScrapingStrategy):
        self.strategy = strategy # Recibe como parámetro una estrategia y la almacena en self.strategy

    def get_quotes(self):
        all_quotes = []
        base_url = "https://quotes.toscrape.com/page/{}/" # Define la url base, y en los {} iterará las 5 páginas

        for page in range(1,6): # Itera desde la página 1 hasta la 5
            url = base_url.format(page) # Genera la url de la página actual. Ej: https://quotes.toscrape.com/page/1/
            quotes = self.strategy.scrape(url) # Usa la estratega scrape() para obtener las citas de la página
            all_quotes.extend(quotes) # Añade las quotes obtenidas a la lista de quotes

        return all_quotes
    
# Guardar en YAML
def save_to_yaml(data, filename="quotes.yaml"):         # with ... as file: with cierra el archivo al terminar, y file es la variable que representa el archivo abierto
    with open(filename, "w", encoding="utf-8") as file: # filename es el archivo donde se guarda, w -> modo escritura: borra el contenido si ya existe el archivo
        yaml.dump(data, file, allow_unicode=True) # data son los datos que queremos guardar, y allow_unicode permite guardar caracteres especiales correctamente

# Main
if __name__ == "__main__":
    print("Seleccione la estrategia de scraping:")
    print("1 - BeautifulSoup")
    print("2 - Selenium")

    opcion = input("Ingrese el número de la opción deseada: ").strip()  # .strip elimina los espacios de antes y 
                                                                        # después del número seleccionado para evitar problemas
    if opcion == "1":
        strategy = BeautifulSoupStrategy()
    elif opcion == "2":
        strategy = SeleniumStrategy()
    else:
        print("Opción inválida. Usando BeautifulSoup por defecto.")
        strategy = BeautifulSoupStrategy()

    scraper = Scraper(strategy)

    quotes = scraper.get_quotes()
    save_to_yaml(quotes)

    print(f"Scraping completado. Se guardaron {len(quotes)} citas en 'quotes.yaml'.")

