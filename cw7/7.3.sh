#!/bin/bash

read -p "text: " s
wc -w <<< "$s"
