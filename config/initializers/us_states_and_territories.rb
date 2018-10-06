include Carmen
US_STATES_AND_TERRITORIES = Country.named('United States').subregions.map(&:code).sort
