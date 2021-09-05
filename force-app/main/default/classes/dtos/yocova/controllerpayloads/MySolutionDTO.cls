public class MySolutionDTO {

    @AuraEnabled public String userName { get; set; }
    @AuraEnabled public List<SolutionDTO> solutionDTOs { get; set; }
}