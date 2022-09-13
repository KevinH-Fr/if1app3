
@parisEvent.all.each do |pari|
  coureurId = pari.coureur.id
  typePari = pari.paritype
  
  if Resultat.where(event_id: @eventId, pilote_id: coureurId).present?
    resultatCoureur = Resultat.where(event_id: @eventId, pilote_id: pari.coureur.id).first.course
    resultatQualif = Resultat.where(event_id: @eventId, pilote_id: coureurId).first.qualification
    statutDnsCoureur = Resultat.where(event_id: @eventId, pilote_id: coureurId).first.dns
    pariMontant = pari.montant
    pariCote = pari.cote

      if statutDnsCoureur == true #remboursement dns
        pari.update(resultat: true)
        pari.update(solde: pariMontant )
      else
        if typePari == "victoire" && resultatCoureur == 1 || typePari == "podium" && resultatCoureur <= 3 || typePari == "top10" && resultatCoureur <= 10 || typePari == "pole" && resultatQualif == 1
          pari.update(resultat: true)
          pari.update(solde: pariMontant * pariCote - pariMontant )
        else
          pari.update(resultat: false)
          pari.update(solde: - pariMontant )
        end
      end
  else
    pari.update(resultat: false)
    pari.update(solde: - pariMontant )
  end