import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import './styles.css';

const medicalTerms = [
  { id: 1, term: 'Aneurisma', definition: 'Dilatación anormal de un vaso sanguíneo.' },
  { id: 2, term: 'Bradicardia', definition: 'Frecuencia cardíaca más lenta de lo normal.' },
  { id: 3, term: 'Cianosis', definition: 'Coloración azulada de la piel debido a falta de oxígeno.' },
  // Añadir más términos aquí hasta llegar a 100
];

const MedicalDictionary = () => {
  const [search, setSearch] = useState('');

  const filteredTerms = medicalTerms.filter((term) =>
    term.term.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="container">
      <h1>Diccionario Médico</h1>
      <input
        type="text"
        placeholder="Buscar término..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        style={{
          width: '100%',
          padding: '10px',
          marginBottom: '20px',
          borderRadius: '5px',
          border: '1px solid #ccc',
        }}
      />
      <table className="table">
        <thead>
          <tr>
            <th>#</th>
            <th>Término</th>
            <th>Definición</th>
          </tr>
        </thead>
        <tbody>
          {filteredTerms.map((item) => (
            <tr key={item.id}>
              <td>{item.id}</td>
              <td>{item.term}</td>
              <td>{item.definition}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

ReactDOM.render(<MedicalDictionary />, document.getElementById('root'));

