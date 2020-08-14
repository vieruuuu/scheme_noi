import infoCard as infoCard

proc render*(av: string): string =
  result = infoCard.render(
    "Antivirus",
    [av],
    "is-warning"
  )
