//
//  TrilhaTests.swift
//  computacao-para-meninasTests
//
//  Created by Ana Macedo on 12/04/26.
//

import XCTest
@testable import computacao_para_meninas

final class TrilhaTests: XCTestCase {

    var viewModel: TrilhaViewModel!

    override func setUp() {
        super.setUp()
        viewModel = TrilhaViewModel()
        viewModel.idsConcluidos = []
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFluxoDeDesbloqueio() {
        let idAtv1 = "atv_1"
        let idAtv2 = "atv_2"
        let estaLiberadaNoInicio = viewModel.estaDesbloqueada(idAtividade: idAtv2, idDependencia: idAtv1)
        XCTAssertFalse(estaLiberadaNoInicio, "ERRO: A Atividade 2 não deveria estar liberada ainda.")
        viewModel.concluirAtividade(id: idAtv1)
        let estaLiberadaDepois = viewModel.estaDesbloqueada(idAtividade: idAtv2, idDependencia: idAtv1)
        XCTAssertTrue(estaLiberadaDepois, "ERRO: A Atividade 2 deveria ter sido liberada após a conclusão da 1.")
    }
    
    func testPersistenciaDeProgresso() {
        let idTeste = "atv_teste_persistencia"
        viewModel.concluirAtividade(id: idTeste)
        let novaViewModel = TrilhaViewModel()
        XCTAssertTrue(novaViewModel.idsConcluidos.contains(idTeste), "ERRO: O progresso deveria ter sido persistido no AppStorage.")
    }
}
