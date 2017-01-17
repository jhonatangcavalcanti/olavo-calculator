require "spec_helper"

describe Calculator do
  it "has a version number" do
    expect(Calculator::VERSION).not_to be nil
  end

  it "reconhece um número positivo" do
	  expect(Calculator.solve('2341')).to eq(2341.0)
  end

  it "reconhece um número negativo" do
	  expect(Calculator.solve('-3513')).to eq(-3513)
  end

  it "reconhece um número de ponto flutuante" do
	  expect(Calculator.solve('-34.1532')).to eq(-34.1532)
  end

  it "soma dois números" do
    expect(Calculator.solve('3+2')).to eq(5)
  end

  it "executa todas as quatro operações básicas" do
	  expect(Calculator.solve('12/2 + 17 - 6*2')).to eq(11)
  end

  it "executa operações com parênteses" do
	  expect(Calculator.solve('3/(1+2)')).to eq(1)
  end

  it "executa operações com chaves" do
	  expect(Calculator.solve('{4+2}*5')).to eq(30)
  end

  it "executa operações com colchetes" do
	  expect(Calculator.solve('[10/(3+2)]')).to eq(2)
  end

  it "executa operações com números negativos" do
	  expect(Calculator.solve('-3*-4')).to eq(12)
  end

  it "retorna um erro de semântica" do
	  expect { Calculator.solve('{2+1)') }.to raise_error("Semantic Error")
  end

  it "executa o caso de teste '4+{[3*(2+1)] + 1}'" do
	  expect(Calculator.solve('4+{[3*(2+1)] + 1}')).to eq(14)
  end

end
