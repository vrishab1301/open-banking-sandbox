package com.vrishab.bank.transaction;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/accounts/{accountId}/transactions")
public class TransactionController {

    private final TransactionRepository transactionRepository;

    public TransactionController(TransactionRepository transactionRepository) {
        this.transactionRepository = transactionRepository;
    }

    @GetMapping
    public List<TransactionResponse> listTransactions(@PathVariable Long accountId) {
        return transactionRepository.findByAccountIdOrderByPostedAtDesc(accountId)
                .stream()
                .map(TransactionResponse::from)
                .toList();
    }
}