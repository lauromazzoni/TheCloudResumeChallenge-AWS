const counter = document.getElementById("visits");
const apiUrl = "https://b1g432dvy6.execute-api.us-east-1.amazonaws.com/prod/counter";

async function updateCounter() {
  try {
    let response = await fetch(apiUrl);
    let data = await response.json();

    // o campo "visits" vem dentro de "body" como string JSON
    let parsedBody = JSON.parse(data.body);

    counter.innerText = parsedBody.visits;
  } catch (err) {
    console.error("Erro ao buscar contador:", err);
    counter.innerText = "N/A";
  }
}

updateCounter();

