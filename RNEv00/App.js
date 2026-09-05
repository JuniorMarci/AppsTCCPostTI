import React, { useState } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { sequencial } from './sequencial.js';

export default function App() {
  const [TelaAtiva, setTelaAtiva] = useState("Inicio");

  switch (TelaAtiva) {
    case "Inicio": 
      return <Inicio onNavigate={setTelaAtiva} />;
    case "Pagina1": 
      return <Pagina1 onNavigate={setTelaAtiva} />;
    default:
      return null;
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
  },
  text: {
    fontSize: 24,
  },
});

function Inicio({ onNavigate }) {
  const r = sequencial(1)[0]["fim"];

  return (
    <View style={styles.container}>
      <Text style={styles.text}>
        Legal{"\n"}{r}{"\n"}
      </Text>
      <Text style={styles.text} onPress={() => onNavigate("Pagina1")}>
        Página 1
      </Text>
    </View>
  );
}

function Pagina1({ onNavigate }) {
  const r = sequencial(1)[0]["fim"];

  return (
    <View style={styles.container}>
      <Text style={styles.text}>
        Página 1{"\n"}{r}{"\n"}
      </Text>
      <Text style={styles.text} onPress={() => onNavigate("Inicio")}>
        Voltar
      </Text>
    </View>
  );
}