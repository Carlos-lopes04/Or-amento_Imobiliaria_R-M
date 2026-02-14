import csv

print("===================================")
print("   SISTEMA DE ORÇAMENTO - R.M")
print("===================================\n")

# Escolha do imóvel
print("Tipos de imóvel:")
print("1 - Apartamento (R$ 700,00)")
print("2 - Casa (R$ 900,00)")
print("3 - Estúdio (R$ 1.200,00)")

tipo = int(input("Escolha o tipo de imóvel: "))

# Definição do valor base
if tipo == 1:
    aluguel = 700
    tipo_nome = "Apartamento"
elif tipo == 2:
    aluguel = 900
    tipo_nome = "Casa"
elif tipo == 3:
    aluguel = 1200
    tipo_nome = "Estúdio"
else:
    print("Opção inválida!")
    exit()

# Quantidade de quartos
if tipo in [1, 2]:
    quartos = int(input("Quantos quartos (1 ou 2)? "))
    if quartos == 2:
        if tipo == 1:
            aluguel += 200
        else:
            aluguel += 250

# Garagem para casa e apartamento
if tipo in [1, 2]:
    garagem = input("Deseja vaga de garagem? (s/n): ")
    if garagem.lower() == "s":
        aluguel += 300

# Estúdio – vagas de estacionamento
if tipo == 3:
    vagas = int(input("Quantas vagas de estacionamento deseja? "))
    if vagas >= 2:
        aluguel += 250
        if vagas > 2:
            aluguel += (vagas - 2) * 60

# Desconto para apartamento sem crianças
if tipo == 1:
    criancas = input("Possui crianças? (s/n): ")
    if criancas.lower() == "n":
        desconto = aluguel * 0.05
        aluguel -= desconto
    else:
        desconto = 0
else:
    desconto = 0

# Dados do contrato
valor_contrato = 2000
parcelas = int(input("Em quantas parcelas deseja pagar o contrato (1 a 5)? "))

if parcelas < 1 or parcelas > 5:
    print("Número de parcelas inválido!")
    exit()

valor_parcela = valor_contrato / parcelas

# Resultado final
print("\n==============================")
print("     ORÇAMENTO FINAL")
print("==============================")
print(f"Tipo de imóvel: {tipo_nome}")
print(f"Valor do aluguel mensal: R$ {aluguel:.2f}")
print(f"Valor do contrato: R$ {valor_contrato:.2f}")
print(f"Parcelado em {parcelas}x de R$ {valor_parcela:.2f}")

# Geração do CSV
with open("parcelas.csv", "w", newline="", encoding="utf-8") as arquivo:
    escritor = csv.writer(arquivo)
    escritor.writerow(["Mês", "Valor do Aluguel"])

    for mes in range(1, 13):
        escritor.writerow([mes, f"{aluguel:.2f}"])

print("\nArquivo 'parcelas.csv' gerado com sucesso!")
print("Contém as 12 parcelas mensais do aluguel.")
