function confirmDelete(url) {
    if (confirm('Êtes-vous sûr de vouloir supprimer cette facture ?')) {
        window.location.href = url;
    }
}

function confirmDeleteAccount(url) {
    if (confirm('Êtes-vous sûr de vouloir supprimer votre compte ?')) {
        window.location.href = url;
    }
}

function confirmCancel(url) {
    if (confirm('Êtes-vous sûr de vouloir quitter cette page ?')) {
        window.location.href = url;
    }
}