#!/bin/bash

# Créer un chunk texte de base (~80 bytes par ligne)
cat > /tmp/base_words.txt << 'WORDS'
apache spark distributed computing framework processes big data across clusters
machine learning algorithms analyze patterns in massive datasets efficiently
python java scala programming languages support functional reactive paradigms
cloud infrastructure scales horizontally using containerized microservices architecture
network protocols transmit packets through routers switches and firewalls securely
database systems optimize queries using indexes caching and query planning
artificial intelligence models train on gpus using backpropagation gradient descent
distributed systems handle failures through replication consensus and partitioning
WORDS

gen() {
    local name=$1
    local size_mb=$2
    local output="test_${name}.txt"
    
    echo "Génération de ${output} (${size_mb} MB)..."
    
    # Calculer le nombre de lignes nécessaires
    # ~80 bytes par ligne = ~12500 lignes pour 1MB
    local lines=$((size_mb * 12500))
    
    # Générer avec shuf pour randomiser
    shuf -r -n $lines /tmp/base_words.txt > "$output"
    
    local actual=$(du -h "$output" | cut -f1)
    echo "✅ ${output} créé : ${actual}"
    echo ""
}

rm -f test_*.txt

gen "10mb"   10
gen "50mb"   50
gen "100mb"  100
gen "250mb"  250
gen "500mb"  500
gen "1gb"    1024
gen "2gb"    2048
gen "10gb"   10240

rm /tmp/base_words.txt

ls -lh test_*.txt