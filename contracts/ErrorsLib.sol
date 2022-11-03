// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library ErrorsLib {
  error MinterNotEnoughFunds(uint requested, uint available);
  error UserNotEnoughFunds(uint requested, uint available);
}
