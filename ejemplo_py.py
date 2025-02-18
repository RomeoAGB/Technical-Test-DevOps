"""
Función para saludar a un usuario.
"""

def saludar(nombre: str) -> str:
    """Retorna un saludo con nombre personalizado"""
    return f"¡Hola, {nombre}!"

def main():
    """Imprime un saludo."""
    nombre = "Romeo"
    saludo = saludar(nombre)
    print(saludo)

if __name__ == "__main__":
    main()
