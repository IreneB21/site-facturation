const allPayementStatus = document.getElementsByClassName('status');

for (let i=0; i<allPayementStatus.length; i++) {
    let statusContent = allPayementStatus[i].textContent.trim().toLowerCase();

    if (statusContent === "à encaisser") {
        allPayementStatus[i].style.color = "#FD9B63";
    } else if (statusContent === "à relancer") {
        allPayementStatus[i].style.color = "#FF0000";
    } else {
        allPayementStatus[i].style.color = "#A1DD70";
    }
}

function confirmStatusChange(url) {
    if (confirm('Êtes-vous sûr de vouloir marquer cette facture comme payée ?')) {
        window.location.href = url;
    }
}