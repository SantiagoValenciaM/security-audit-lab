const fs = require('fs');

// Leer tu archivo de vulnerabilidades
const vulnData = JSON.parse(fs.readFileSync('vulnerabilities.json', 'utf8'));

// Convertir a formato SARIF
const sarifReport = {
  version: '2.1.0',
  runs: [{
    tool: {
      driver: {
        name: 'Custom Security Scanner',
        informationUri: 'https://github.com/your-repo',
        rules: vulnData.vulnerabilities.map(v => ({
          id: v.id,
          name: v.type,
          shortDescription: { text: v.type },
          fullDescription: { text: v.description },
          defaultConfiguration: { level: mapSeverity(v.severity) },
          properties: { 
            tags: ['security', 'custom'],
            cwe: v.cwe
          }
        }))
      }
    },
    results: vulnData.vulnerabilities.map(v => ({
      ruleId: v.id,
      level: mapSeverity(v.severity),
      message: { 
        text: `${v.description}\nCWE: ${v.cwe}\nRemediation: ${v.remediation}`
      },
      locations: [{
        physicalLocation: {
          artifactLocation: { uri: v.file },
          region: { 
            startLine: v.line,
            startColumn: 1,
            endLine: v.line,
            endColumn: 100
          }
        }
      }],
      codeFlows: [{
        threadFlows: [{
          locations: [{
            location: {
              message: { text: v.code },
              physicalLocation: {
                artifactLocation: { uri: v.file },
                region: { startLine: v.line }
              }
            }
          }]
        }]
      }]
    }))
  }]
};

function mapSeverity(severity) {
  const map = {
    'CRITICAL': 'error',
    'HIGH': 'error',
    'MEDIUM': 'warning',
    'LOW': 'note'
  };
  return map[severity] || 'warning';
}

// Guardar en formato SARIF
fs.writeFileSync('security-report.sarif', JSON.stringify(sarifReport, null, 2));
console.log('✅ SARIF report generated: security-report.sarif');
