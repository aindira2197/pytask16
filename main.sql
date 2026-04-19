CREATE TABLE Murakkab_Matn (
  id SERIAL PRIMARY KEY,
  matn TEXT NOT NULL,
  sana DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE Regex_Patterns (
  id SERIAL PRIMARY KEY,
  pattern TEXT NOT NULL,
  description TEXT
);

CREATE TABLE Parsed_Matn (
  id SERIAL PRIMARY KEY,
  matn_id INTEGER NOT NULL REFERENCES Murakkab_Matn(id),
  regex_id INTEGER NOT NULL REFERENCES Regex_Patterns(id),
  result TEXT
);

INSERT INTO Regex_Patterns (pattern, description)
VALUES
  ('^[a-zA-Z]+$', 'Faqat harflar'),
  ('^[0-9]+$', 'Faqat sonlar'),
  ('^[a-zA-Z0-9]+$', 'Harflar va sonlar');

CREATE OR REPLACE FUNCTION parse_matn(p_matn TEXT, p_regex TEXT)
RETURNS TEXT AS $$
DECLARE
  result TEXT;
BEGIN
  IF p_matn ~ p_regex THEN
    result := 'Mos';
  ELSE
    result := 'Mos emas';
  END IF;
  RETURN result;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION parse_all_matn()
RETURNS VOID AS $$
DECLARE
  r RECORD;
  regex RECORD;
BEGIN
  FOR r IN SELECT * FROM Murakkab_Matn
  LOOP
    FOR regex IN SELECT * FROM Regex_Patterns
    LOOP
      INSERT INTO Parsed_Matn (matn_id, regex_id, result)
      VALUES (r.id, regex.id, parse_matn(r.matn, regex.pattern));
    END LOOP;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

INSERT INTO Murakkab_Matn (matn)
VALUES
  ('Hello World'),
  ('12345'),
  ('abc123');

SELECT * FROM Murakkab_Matn;
SELECT * FROM Regex_Patterns;
SELECT * FROM Parsed_Matn;

CALL parse_all_matn();

SELECT * FROM Parsed_Matn;