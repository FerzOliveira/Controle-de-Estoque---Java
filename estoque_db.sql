-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05-Out-2021 às 00:07
-- Versão do servidor: 10.4.19-MariaDB
-- versão do PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `estoque_db`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cor`
--

CREATE TABLE `cor` (
  `idCor` int(11) NOT NULL,
  `descricaoCor` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `cor`
--

INSERT INTO `cor` (`idCor`, `descricaoCor`) VALUES
(1, 'Preto'),
(2, 'Vermelho');

-- --------------------------------------------------------

--
-- Estrutura da tabela `historico`
--

CREATE TABLE `historico` (
  `idHistorico` int(11) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `operacao` enum('Entrada','Saida') NOT NULL,
  `quantidade` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `historico`
--

INSERT INTO `historico` (`idHistorico`, `idProduto`, `operacao`, `quantidade`, `data`) VALUES
(1, 1, 'Entrada', 5, '2021-08-26'),
(2, 3, 'Entrada', 15, '2021-08-26'),
(3, 2, 'Entrada', 8, '2021-08-26'),
(4, 3, 'Saida', 3, '2021-08-26'),
(5, 3, 'Saida', 2, '2021-09-02'),
(6, 1, 'Saida', 1, '2021-09-08'),
(7, 1, 'Saida', 1, '2021-09-08'),
(8, 2, 'Saida', 1, '2021-09-08'),
(9, 2, 'Saida', 1, '2021-09-08'),
(10, 3, 'Saida', 1, '2021-09-09');

-- --------------------------------------------------------

--
-- Estrutura da tabela `marca`
--

CREATE TABLE `marca` (
  `idMarca` int(11) NOT NULL,
  `descricaoMarca` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `marca`
--

INSERT INTO `marca` (`idMarca`, `descricaoMarca`) VALUES
(1, 'Ardidas'),
(2, 'Mike');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `idProduto` int(11) NOT NULL,
  `codProduto` int(11) NOT NULL,
  `descricaoProduto` varchar(80) NOT NULL,
  `precoProduto` double NOT NULL,
  `idMarca` int(11) NOT NULL,
  `idCor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`idProduto`, `codProduto`, `descricaoProduto`, `precoProduto`, `idMarca`, `idCor`) VALUES
(1, 100101, 'Tenis de corrida', 139, 1, 1),
(2, 100201, 'Sapato de dança', 350, 2, 2),
(3, 100301, 'Sapato Maluco', 322, 2, 2);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cor`
--
ALTER TABLE `cor`
  ADD PRIMARY KEY (`idCor`);

--
-- Índices para tabela `historico`
--
ALTER TABLE `historico`
  ADD PRIMARY KEY (`idHistorico`),
  ADD KEY `fk_hist_p` (`idProduto`);

--
-- Índices para tabela `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`idMarca`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`idProduto`),
  ADD KEY `fk_marca` (`idMarca`),
  ADD KEY `fk_cor` (`idCor`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cor`
--
ALTER TABLE `cor`
  MODIFY `idCor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `historico`
--
ALTER TABLE `historico`
  MODIFY `idHistorico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `marca`
--
ALTER TABLE `marca`
  MODIFY `idMarca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `idProduto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `historico`
--
ALTER TABLE `historico`
  ADD CONSTRAINT `fk_hist_p` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_cor` FOREIGN KEY (`idCor`) REFERENCES `cor` (`idCor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_marca` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
