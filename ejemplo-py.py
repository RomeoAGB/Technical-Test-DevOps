def saludar(nombre, apellido):
    return f"¡Hola, {nombre} {apellido}!"

def main():
    nombre = "Romeo"
    apellido = "Gómez"
    saludo = saludar(nombre, apellido)
    print(saludo)

if __name__ == "__main__":
    main()