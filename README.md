# CrowdFunding-Smart-Contract
The contract enables users to contribute Ether to a fundraising campaign, vote on spending requests, and ensures transparent fund usage through majority voting.

📌 Project Overview

The CrowdFunding smart contract allows:

Multiple users to contribute ETH

A manager to create spending requests

Contributors to vote on requests

Funds to be released only after majority approval

Refunds if the funding target is not reached before the deadline

This project demonstrates core blockchain concepts such as decentralization, trustless governance, and smart contract–based fund management.

🚀 Features

💰 Minimum Contribution Enforcement

⏳ Time-based Deadline

🎯 Target-based Fundraising

🗳️ Voting System for Spending Requests

🔒 Manager-only Controls

🔁 Refund Mechanism

📊 Transparent Fund Tracking

🧱 Smart Contract Structure
Key State Variables

manager – Contract creator

minimumContribution – Minimum ETH required to contribute

deadline – Fundraising deadline (timestamp)

target – Fundraising goal

raisedAmount – Total ETH raised

contributors – Tracks contributions per address

Request Structure

Each spending request includes:

Description

Recipient address

Amount requested

Vote count

Completion status

Voter tracking to prevent double voting

🔧 Functions Explained
sendEth()

Allows users to contribute ETH before the deadline.

refund()

Enables contributors to withdraw funds if the target is not met after the deadline.

createRequests()

Allows the manager to create spending requests.

voteRequest()

Allows contributors to vote on a spending request (one vote per contributor).

makePayment()

Transfers ETH to the recipient after majority approval.

getContractBalance()

Returns the contract’s ETH balance.

🔐 Access Control

Only the manager can:

Create spending requests

Execute payments

Only contributors can vote

🛠️ Tech Stack

Solidity ^0.8.0

**Ethereum Virtual Machine (EVM)`

Remix IDE (for deployment and testing)

📦 Deployment Steps

Open Remix IDE

Create a new Solidity file and paste the contract

Compile using Solidity ^0.8.x

Deploy with constructor parameters:

_target

_deadline (in seconds)

Interact using injected provider or local VM

⚠️ Notes

Refund is available only if the target is not reached

Voting power is proportional to contributor count

Double voting is prevented

ETH transfers use transfer() for safety

📜 License

This project is licensed under the GPL-3.0 License.

👨‍💻 Author

Yashwant Gupta
Blockchain & Full Stack Developer
