const counter = document.getElementById("visits");
const apiUrl = "https://b1g432dvy6.execute-api.us-east-1.amazonaws.com/prod/counter";

async function updateCounter() {
  try {
    let response = await fetch(apiUrl);
    let data = await response.json();
    counter.innerText = data.visits;
  } catch (err) {
    console.error("Erro:", err);
    counter.innerText = "N/A";
  }
}

updateCounter();

