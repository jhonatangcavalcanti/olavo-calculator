require "spec_helper"

describe Calculator do
  it "has a version number" do
    expect(Calculator::VERSION).not_to be nil
  end

  it "reconhece um número positivo" do
	  expect(Calculator.solve('2341')).to be 2341
  end

  it "reconhece um número negativo" do
	  expect(Calculator.solve('-3513')).to be -3513
  end

  it "reconhece um número de ponto flutuante" do
	  expect(Calculator.solve('-34.1532')).to be -34.1532
  end

  it "soma dois números" do
    expect(Calculator.solve('3+2')).to be 5
  end

  it "executa todas as quatro operações básicas" do
	  expect(Calculator.solve('12/2 + 17 - 6*2')).to be 11
  end

  it "executa operações com parênteses" do
	  expect(Calculator.solve('3/(1+2)')).to be 1
  end

  it "executa operações com chaves" do
	  expect(Calculator.solve('{4+2}*5')).to be 30
  end

  it "executa operações com colchetes" do
	  expect(Calculator.solve('[10/(3+2)]')).to be 2
  end

  it "executa operações com números negativos" do
	  expect(Calculator.solve('-3*-4')).to be 12
  end

end
