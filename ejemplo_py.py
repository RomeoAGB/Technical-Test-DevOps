
def saludar(nombre: str) -> str:
    return f"¡Hola, {nombre}!"

def main():
    nombre = "Romeo"
    saludo = saludar(nombre)
    print(saludo)

if __name__ == "__main__":
    main()